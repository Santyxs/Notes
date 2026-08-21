package com.santos.tareas

import android.app.AlertDialog
import android.content.Context
import android.text.InputType
import android.widget.EditText
import android.widget.Toast

object PinDialogHelper {

    /** Pide crear un PIN de 4 dígitos (dos veces, para confirmar). */
    fun showCreatePinDialog(context: Context, onCreated: (String) -> Unit) {
        askPin(context, "Crea un PIN de 4 dígitos") { firstPin ->
            if (firstPin.length != 4) {
                Toast.makeText(context, "El PIN debe tener 4 dígitos", Toast.LENGTH_SHORT).show()
                return@askPin
            }
            askPin(context, "Confirma el PIN") { secondPin ->
                if (firstPin == secondPin) {
                    PinLockManager.setPin(context, firstPin)
                    onCreated(firstPin)
                } else {
                    Toast.makeText(context, "Los PIN no coinciden", Toast.LENGTH_SHORT).show()
                }
            }
        }
    }

    /** Pide el PIN existente y verifica contra el guardado. */
    fun showEnterPinDialog(context: Context, onCorrect: () -> Unit, onCancel: (() -> Unit)? = null) {
        askPin(context, "Introduce tu PIN", onCancel) { pin ->
            if (PinLockManager.verifyPin(context, pin)) {
                onCorrect()
            } else {
                Toast.makeText(context, "PIN incorrecto", Toast.LENGTH_SHORT).show()
                onCancel?.invoke()
            }
        }
    }

    private fun askPin(
        context: Context,
        title: String,
        onCancel: (() -> Unit)? = null,
        onSubmit: (String) -> Unit
    ) {
        val input = EditText(context)
        input.inputType = InputType.TYPE_CLASS_NUMBER or InputType.TYPE_NUMBER_VARIATION_PASSWORD
        input.hint = "••••"

        AlertDialog.Builder(context)
            .setTitle(title)
            .setView(input)
            .setPositiveButton("Aceptar") { _, _ -> onSubmit(input.text.toString()) }
            .setNegativeButton("Cancelar") { _, _ -> onCancel?.invoke() }
            .setCancelable(false)
            .show()
    }
}
